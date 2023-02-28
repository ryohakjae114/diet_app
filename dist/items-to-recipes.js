// 全てのアイテムをレシピに追加するやつ。
// 管理ページにログインした状態でコンソールを開いてこれを貼り付ける。

(async () => {

  const itemsResponse = await fetch("/admins/items.json")
  const items = (await itemsResponse.json()).slice(0, 500) // 件数指定. Chromeだと同時にやりすぎるとエラーになるので減らす. slice(500, 500)なら500件目から500個（999件目まで）を登録する
  console.log(items.length)
  // console.log(items.map(item => item.id))
  let completeCount = 0

  await Promise.allSettled(items.map(item => (async () => {
    const res = await fetch(`/admins/recipes`, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.content,
      },
      body: JSON.stringify({
        recipe: {
          img_url: null,
          name: `${item.name}(単)`,
          cook_at: '外食・市販',
        }
      }),
    })
    const recipe = await res.json();
    try {
      // レシピを追加したときのJSONがバグってるが登録はできるのでとりあえずエラーを無視する
      const res2 = await fetch(`/admins/recipes/${recipe.id}/recipe_items`, {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.content,
        },
        body: JSON.stringify({
          recipe_item: {
            item_id: item.id,
            weight: item.weight,
          }
        }),
      })
    } catch {}
    completeCount++
    if (completeCount % 50 === 0) console.log(completeCount)
    return
  })()));
  console.log('ok');
})()

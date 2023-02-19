class Api::V1::DietGoalsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :can_build_diet_goal, only: :create
  before_action :set_diet_goal, only: %i[show advise destroy]
  before_action ->{
    data_owner(@diet_goal)
  }, only: %i[show advise]
  before_action :diet_not_finished, only: :advise

  def create
    if @user.diet_goal.present?
      render json: { status: 'ERROR', message: 'current_user already have diet_goal', data: @user.diet_goal }
    else
      @diet_goal = @user.build_diet_goal(diet_goal_params)
      @diet_goal.set_daily_kcal(@user)

      if @diet_goal.save
        render json: { status: 'SUCCESS', data: @diet_goal }
      else
        render json: { status: 'ERROR', data: @diet_goal.errors }
      end
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the diet_goal', data: @diet_goal }
  end

  def advise
    #date変数...
    @advise           = ''
    difference_advise = ''
    balance_advise    = ''
    daily_nutrients   = @user.daily_nutrients(params[:date])
    ideal_balance     = { protein: false, fat: false, carb: false }
    ideal_count       = 0

    if daily_nutrients
      #1日のおすすめkcalに比べてどのような状況なのか。
      difference = @diet_goal.daily_kcal - daily_nutrients[:kcal]

      if difference < 0
        difference_advise << "1日あたりの、目標接種カロリーを#{difference}kcal分上回っています。少しメニューを工夫してみましょう。"
      else
        difference_advise << "1日あたりの、目標接種カロリーまで残り#{difference}kcalです。"
      end

      #栄養バランスはどうなのか。
      sum_nutrients = daily_nutrients[:protein] + daily_nutrients[:carb] + daily_nutrients[:fat]

      rate_protein  = (daily_nutrients[:protein] / sum_nutrients).round(1)*100
      rate_fat      = (daily_nutrients[:fat] / sum_nutrients).round(1)*100
      rate_carb     = (daily_nutrients[:carb] / sum_nutrients).round(1)*100
      
      if 13 <= rate_protein && rate_protein  <= 20
        ideal_balance[:protein] = true
        ideal_count += 1
      end

      if 20 <= rate_fat && rate_fat <= 30
        ideal_balance[:fat] = true
        ideal_count += 1
      end

      if 50 <= rate_carb && rate_carb <= 65
        ideal_balance[:carb] = true
        ideal_count += 1
      end

      if ideal_count == 3
        balance_advise << "タンパク質、脂質、炭水化物の全てが理想的な割合です。"
      else
        balance_advise << "現在の1日の食事メニューでは、"
        balance_advise << "タンパク質が#{rate_protein}%、"
        balance_advise << "脂質が#{rate_fat}%、"
        balance_advise << "炭水化物が#{rate_carb}%、"
        balance_advise << "その他が#{100-rate_protein-rate_fat-rate_carb}%です。"
        balance_advise << "理想の栄養バランスはタンパク質が13-20%、脂質が20-30%、炭水化物が50-65%です。少しメニューを変更してみましょう"
      end

      @advise << difference_advise << balance_advise

      render json: { status: 'SUCCESS', message: 'Advise to user', data: @advise }
    else
      render json: { status: 'ERROR', message: 'not valid menu' }
    end
  end

  def destroy
    @diet_goal.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the diet_goal', data: @diet_goal }
  end

  private

  def set_diet_goal
    @diet_goal = current_api_v1_user.diet_goal

    if @diet_goal.nil?
      render json: { status: 'ERROR', message: 'not have diet_goal' }
    end
  end

  # Only allow a list of trusted parameters through.
  def diet_goal_params
    params.fetch(:diet_goal, {}).permit(:weight, :date)
  end

  def can_build_diet_goal
    @user = current_api_v1_user
    if @user.gender.nil? || @user.age.nil? || @user.weight.nil? || @user.height.nil? || @user.daily_momentum.nil?
      render json: { status: 'ERROR', message: "user must input gender,age,weight,height,daily_momentum" }
    end
  end

  def diet_not_finished
    @user = current_api_v1_user

    if @diet_goal.date <= Date.today
      if @diet_goal.weight >= @user.weight
        render json: { status: 'ERROR', message: 'finished and achieved!', data: @diet_goal }
      else
        render json: { status: 'ERROR', message: 'finished and not achieved', data: @diet_goal }
      end
    end
  end

  def to_percent(decimal)
    return decimal.round(1)*100
  end
end

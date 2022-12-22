class Admins::DiariesController < ApplicationController
  before_action :set_diary
  before_action :update_param

  def update
    respond_to do |format|
      if @diary.update(update_param)
        format.html { redirect_to admins_user_url(@diary.user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: admins_user_url(@diary.user) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    def set_diary
      @diary = Diary.find(params[:id])
    end

    def update_param
      params.require(:diary).permit(:activated)
    end
end

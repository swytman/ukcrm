class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :users]

  def index
    @items = User.all
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = User.new
    @item.village_code = params[:village_code] if params[:village_code].present?
  end

  def update
    if @item.update(item_params)
      redirect_to edit_user_path(@item), notice: 'Изменения сохранены'
    else
      render "users/edit"
    end
  end


  def create
    @item = User.new(item_params)
    # generated_password = Devise.friendly_token.first(8)
    # @item.password = generated_password
    if @item.save(validate: false)
      redirect_to users_village_path(@item.village), notice: 'Создано'
    else
      render :new, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to users_path, notice: 'Удалено'
    else
      redirect_to users_path, notice: 'Ошибка при удалении'
    end
  end

  def tariffs
    @tariffs = Tariff.by_code(@item.code)
  end

  private

  def item_params
    params[:user].permit(:title, :village_code, :email )
  end

  def set_item
    @item = User.find(params[:id])
  end

end
class VillagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :users]

  def index
    @items = Village.all
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = Village.new
  end

  def update
    if @item.update(item_params)
      redirect_to edit_village_path(@item), notice: 'Изменения сохранены'
    else
      render "villages/edit"
    end
  end

  def users
    @items = User.where(village_code: @item.code)
    # @home = users_villages_path(@item)
  end

  def create
    @item = Village.new(item_params)
    if @item.save
      redirect_to villages_path, notice: 'Создано'
    else
      render :new, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to villages_path, notice: 'Удалено'
    else
      redirect_to villages_path, notice: 'Ошибка при удалении'
    end
  end

  def tariffs
    @tariffs = Tariff.by_code(@item.code)
  end

  private

  def item_params
    params[:village].permit(:title, :code )
  end

  def set_item
    @item = Village.find(params[:id])
  end

end
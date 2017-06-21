class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :meterings]
  before_action :set_parents

  def index
    @items = @village.properties
  end

  def show

  end

  def edit

  end

  def meterings
    @counters = @item.village.counters
    @counter =  @counters.first
    @counter =  Counter.find(params[:counter_id]) if params[:counter_id]
    @items = @counter.meterings.where(user_id: @item.id).order('year DESC, month DESC')
  end

  def new
    @property = @item = Property.new
  end

  def update
    if @item.update(item_params)
      redirect_to edit_village_property_path(@village, @item), notice: 'Изменения сохранены'
    else
      render "villages/edit"
    end
  end

  def create
    @item = Property.new(item_params)
    if @item.save
      redirect_to village_properties_path(@village), notice: 'Создано'
    else
      render :new, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to village_properties_path(@village), notice: 'Удалено'
    else
      redirect_to village_properties_path(@village), notice: 'Ошибка при удалении'
    end
  end

  private

  def item_params
    params[:property].permit(:title, :user_id, :village_id, :ptype )
  end

  def set_item
    @village = @item = Property.find(params[:id])
  end

  def set_parents
    @village = Village.find(params[:village_id])
  end

end
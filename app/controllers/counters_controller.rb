class CountersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :tariffs]
  before_action :set_parents


  def index
    @items = @village.counters
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = @village.counters.new
  end

  def update
    if @item.update(item_params)
      redirect_to edit_village_counter_path(@village, @item), notice: 'Изменения сохранены'
    else
      render "counters/edit"
    end
  end

  def create
    @item = @village.counters.new(item_params)
    if @item.save
      redirect_to village_counters_path(@village), notice: 'Создано'
    else
      render :new
    end
  end

  def destroy
    if @item.destroy
      redirect_to village_counters_path(@village), notice: 'Удалено'
    else
      redirect_to village_counters_path(@village), notice: 'Ошибка при удалении'
    end
  end

  def tariffs
    @tariffs = @item.tariffs
  end

  private

  def item_params
    params[:counter].permit(:title, :code, :unit, :village_code, :editable_by_settler )
  end

  def set_item
    @item = Counter.find(params[:id])
  end

  def set_parents
    @village = Village.find(params[:village_id])
  end

end
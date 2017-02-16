class CountersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :tariffs]

  def index
    @items = @village.counters
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = Counter.new(village_code: params[:village_code])
  end

  def update
    if @item.update(item_params)
      redirect_to edit_counter_path(@item), notice: 'Изменения сохранены'
    else
      render "counters/edit"
    end
  end

  def create
    @item = Counter.new(item_params)
    if @item.save
      redirect_to counters_village_path(@item.village), notice: 'Создано'
    else
      render :new
    end
  end

  def destroy
    if @item.destroy
      redirect_to counters_village_path(@item.village), notice: 'Удалено'
    else
      redirect_to counters_village_path(@item.village), notice: 'Ошибка при удалении'
    end
  end

  def tariffs
    @tariffs = Tariff.by_code(@item.code)
  end

  private

  def item_params
    params
    params[:counter].permit(:title, :code, :unit, :village_code )
  end

  def set_item
    @item = Counter.find(params[:id])
  end

end
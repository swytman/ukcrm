class TariffsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_parents
  before_action :set_env
  before_filter :authenticate_user!

  def index
    @items = @counter.tariffs
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = @counter.tariffs.new
  end

  def update
    if @item.update(item_params)
      redirect_to village_counter_tariffs_path(@village, @counter), notice: 'Изменения сохранены'
    else
      render "tariffs/edit"
    end
  end

  def create
    @item = @counter.tariffs.new(item_params)
    if @item.save
      redirect_to village_counter_tariffs_path(@village, @counter), notice: 'Создано'
    else
      render :edit, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to village_counter_tariffs_path(@village, @counter), notice: 'Удалено'
    else
      redirect_to village_counter_tariffs_path(@village, @counter), notice: 'Ошибка при удалении'
    end
  end

  private

  def set_env
    if @item
      @counter = @item.counter
      @village = @item.village
    elsif params[:counter_id]
      @counter = Counter.find(params[:counter_id])
      @village = @counter.village if @counter
    end
  end

  def item_params
    params[:tariff][:rate] = params[:tariff][:rate].gsub(',', '.') if params[:tariff][:rate]

    params[:tariff].permit(:year, :month, :rate)
  end

  def set_item
    @item = Tariff.find(params[:id])
  end

  def set_parents
    @village = Village.find(params[:village_id])
    @counter = Counter.find(params[:counter_id])
  end

end
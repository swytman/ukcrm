class MeteringsController < ApplicationController
  include VillageInit
  before_filter :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_parents

  def index
    @counters = @property.village.counters
    @counter =  @counters.first
    @counter =  Counter.find(params[:counter_id]) if params[:counter_id]
    @items = @counter.meterings.where(property_id: @property.id).order('year DESC, month DESC')
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = @counter.meterings.new(property_id: @property.id)
    last_metering = @counter.meterings.where(property_id: @property.id).order('year DESC, month DESC').try(:first)
    if last_metering
      next_obj = Helpers::Month.next_month(last_metering.month, last_metering.year)
      @item.year = next_obj[:year]
      @item.month = next_obj[:month]
      @item.tariff = @counter.tariff_for_month(@item.month, @item.year)
    else
      @item.tariff = @counter.tariff_for_month( DateTime.now.month,  DateTime.now.year)
      @item.year = DateTime.now.year
      @item.month =  DateTime.now.month
    end
  end

  def update
    if @item.update(item_params)
      unless item_params[:tariff_id]
        @item.tariff = @item.counter.tariff_for_month(@item.month, @item.year)
        @item.save
      end
      redirect_to village_property_meterings_path(@village, @property, counter_id: @item.counter.id), notice: 'Изменения сохранены'
    else
      render "meterings/edit"
    end
  end



  def create
    @counter = Counter.find(params[:counter_id])
    @item = @property.meterings.new(item_params)

    unless @item.tariff
      @item.tariff = @counter.tariff_for_month(@item.month, @item.year)
    end

    if @item.save
      redirect_to village_property_meterings_path(@village, @property, counter_id: @item.counter.id), notice: 'Создано'
    else
      render :edit, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to village_property_meterings_path(@village, @property, counter_id: @item.counter.id), notice: 'Удалено'
    else
      redirect_to village_property_meterings_path(@village, @property, counter_id: @item.counter.id), notice: 'Ошибка при удалении'
    end
  end


  private

  def set_parents
    @village = Village.find(params[:village_id])
    @property = Property.find(params[:property_id])
    @counter = Counter.find(params[:counter_id]) if params[:counter_id]
    @counter = @item.counter if @item
  end

  def item_params
    params[:metering].permit(:value, :tariff_id, :year, :month)
  end

  def set_item
    @item = Metering.find(params[:id])
  end

end
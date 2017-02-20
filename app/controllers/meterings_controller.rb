class MeteringsController < ApplicationController
  include VillageInit
  before_filter :authenticate_user!
  before_action :set_village_for_index, only: [:index]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_env

  def index
    @counters = @user.village.counters
    @counter =  @counters.first
    @counter =  Counter.find(params[:counter_id]) if params[:counter_id]
    @items = @counter.meterings.where(user_id: @user.id).order('year DESC, month DESC')
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = Metering.new(tariff_id: @counter.current_tariff.id, user_id: @user.id)
    last = Metering.last
    if last
      @item.year = last.year
      @item.month = last.month
    end

  end

  def update
    if @item.update(item_params)
      redirect_to edit_metering_path(code: @item.code), notice: 'Изменения сохранены'
    else
      render "meterings/edit"
    end
  end

  def create
    @item = current_user.meterings.new(item_params)
    if @item.save
      redirect_to meterings_path(counter_id: @item.counter.id), notice: 'Создано'
    else
      render :edit, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to meterings_path(counter_id: @counter.id), notice: 'Удалено'
    else
      redirect_to meterings_path(counter_id: @counter.id), notice: 'Ошибка при удалении'
    end
  end


  private

  def set_env
    if @item
      @counter = @item.counter
    elsif params[:counter_id]
      @counter = Counter.find(params[:counter_id])
    end
  end

  def set_user
    @user = current_user
  end

  def item_params
    params[:metering].permit(:value, :tariff_id, :year, :month)
  end

  def set_item
    @item = Metering.find(params[:id])
  end

end
class MeteringsController < ApplicationController
  include VillageInit
  before_filter :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_parents

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
    @item = @user.meterings.new(tariff_id: @counter.current_tariff.id)
    last = Metering.last
    if last
      @item.year = last.year
      @item.month = last.month
    end

  end

  def update
    if @item.update(item_params)
      redirect_to user_meterings_path(@user, counter_id: @item.counter.id), notice: 'Изменения сохранены'
    else
      render "meterings/edit"
    end
  end

  def create
    @item = @user.meterings.new(item_params)
    if @item.save
      redirect_to user_meterings_path(@user, counter_id: @item.counter.id), notice: 'Создано'
    else
      render :edit, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to user_meterings_path(@user, counter_id: @item.counter.id), notice: 'Удалено'
    else
      redirect_to user_meterings_path(@user, counter_id: @item.counter.id), notice: 'Ошибка при удалении'
    end
  end


  private

  def set_parents
    @user = User.find(params[:user_id])
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
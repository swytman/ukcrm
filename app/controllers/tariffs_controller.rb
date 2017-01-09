class TariffsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @items = Tariff.all
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    code = params[:counter_code] if params[:counter_code].present?
    @item = Tariff.new(counter_code: code)
  end

  def update
    if @item.update(item_params)
      redirect_to tariffs_counter_path(@item.counter), notice: 'Изменения сохранены'
    else
      render "tariffs/edit"
    end
  end

  def create
    item = Tariff.new(item_params)
    if item.save
      redirect_to tariffs_counter_path(item.counter), notice: 'Создано'
    else
      render :edit, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to tariffs_counter_path(@item.counter), notice: 'Удалено'
    else
      redirect_to tariffs_counter_path(@item.counter), notice: 'Ошибка при удалении'
    end
  end

  private

  def item_params
    params[:tariff][:rate] = params[:tariff][:rate].gsub(',', '.') if params[:tariff][:rate]

    params[:tariff].permit(:year, :month, :rate, :counter_code)
  end

  def set_item
    @item = Tariff.find(params[:id])
  end
end
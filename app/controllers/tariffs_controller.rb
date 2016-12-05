class MeteringsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Metering.all
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = Metering.new
  end

  def update
    if @item.update(item_params)
      redirect_to edit_metering_path(@item), notice: 'Изменения сохранены'
    else
      render "meterings/edit"
    end
  end

  def create
    item = Metering.new(item_params)
    if item.save
      redirect_to meterings_path, notice: 'Создано'
    else
      render :edit, notice: 'Ошибка'
    end
  end

  def destroy
    if @item.destroy
      redirect_to meterings_path, notice: 'Удалено'
    else
      redirect_to meterings_path, notice: 'Ошибка при удалении'
    end
  end

  private

  def item_params
    params[:metering][:rate] = params[:metering][:rate].gsub(',', '.') if params[:metering][:rate]

    params[:metering].permit(:title, :code, :rate)
  end

  def set_item
    @item = Metering.find(params[:id])
  end
end
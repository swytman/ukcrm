class MeteringsController < ApplicationController

    before_action :set_item, only: [:show, :edit, :update, :destroy, :tariffs]

    def index
      @codes = Counter.all.map(&:code)
      @code = @codes.first
      @code = params[:code] if params[:code]
      @items = Metering.by_code(@code)
    end

    def show
      redirect_to :action => "edit"
    end

    def edit

    end

    def new
      @code = params[:code] if params[:code]
      @item = Metering.new(tariff_id: Tariff.current(@code).try(:id))
    end

    def update
      if @item.update(item_params)
        redirect_to edit_metering_path(code: @item.code), notice: 'Изменения сохранены'
      else
        render "meterings/edit"
      end
    end

    def create
      item = Metering.new(item_params)
      if item.save
        redirect_to meterings_path(code: item.code), notice: 'Создано'
      else
        render :edit, notice: 'Ошибка'
      end
    end

    def destroy
      if @item.destroy
        redirect_to meterings_path(code: @item.code), notice: 'Удалено'
      else
        redirect_to meterings_path(code: @item.code), notice: 'Ошибка при удалении'
      end
    end

    def tariffs
      @tariffs = Tariff.by_code(@item.code)
    end

    private

    def item_params

      params[:metering].permit(:value, :tariff_id, :year, :month)
    end

    def set_item
      @item = Metering.find(params[:id])
    end

end
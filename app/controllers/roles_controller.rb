class RolesController < ApplicationController

  def index
    @items = Role.order(:id)
  end

  def new
    @item = Role.new
  end

  def create
    @item = Role.new(role_params)
    if @item.save
      redirect_to roles_path(@item)
    else
      render :new,  notice: 'Ошибка'
    end
  end

  def edit
    @item = Role.find(params[:id])
  end

  def destroy
    @item = Role.find(params[:id])
    if @item.destroy
      redirect_to roles_path,  notice: 'Удалено'
    else
      render :edit
    end
  end


  def update
    @item = Role.find(params[:id])

    if @item.update(role_params)
      redirect_to edit_role_path(@item),  notice: 'Изменения сохранены'
    else
      render :edit
    end
  end

  private

  def role_params
    params[:role].permit(:title)
  end
end

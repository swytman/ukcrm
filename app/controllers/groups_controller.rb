class GroupsController < ApplicationController

  def index
    @groups = Group.order(:id)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to edit_group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    if super_groups.include? @group.key
      redirect_to edit_group_path(@group),  notice: 'Нельзя удалить системную группу'
      return
    end
    if @group.destroy
      redirect_to groups_path,  notice: 'Группа удалена'
    else
      render :edit
    end
  end


  def update
    @group = Group.find(params[:id])

    unless @group.admins_will_be_empty? params[:group][:user_ids]
      redirect_to edit_group_path(@group),  notice: 'Нельзя удалить всех администраторов'
      return
    end

    if @group.update(group_params)
      redirect_to edit_group_path(@group),  notice: 'Изменения сохранены'
    else
      render :edit
    end
  end

  private

  def group_params
    params[:group].permit(:key, :title, :user_ids => [], :role_ids => [])
  end
end

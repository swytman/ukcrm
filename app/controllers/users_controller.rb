class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :users, :properties, :remind_to_send_counters]
  before_action :set_redirect_path, only: [:new, :show, :edit, :update, :create, :destroy]

  def index
    @items = current_user.users || []
  end

  def show
    redirect_to :action => "edit"
  end

  def edit

  end

  def new
    @item = User.new
    @item.village_code = Village.find_by(id: params[:village_id]).code if params[:village_id].present?
  end

  def update
    if @item.update(item_params)
      redirect_to @redirect_path || edit_user_path(@item), notice: 'Изменения сохранены'
    else
      render 'edit'
    end
  end


  def create
    @item = User.new(item_params)
    # generated_password = Devise.friendly_token.first(8)
    # @item.password = generated_password
    @item.skip_password_validation = true

    if @item.save
      redirect_to @redirect_path || users_path, notice: 'Создано'
    else
      render :new
    end
  end

  def destroy
    if @item.destroy
      redirect_to @redirect_path || users_path, notice: 'Удалено'
    else
      redirect_to @redirect_path || users_path, notice: 'Ошибка при удалении'
    end
  end



  def properties
    @items = Property.where(user_id: @item.id)
    @village = @item.village
  end

  def remind_to_send_counters
    property_ids = params[:property_ids]
    if @item.is?([:manager, :administrator])
      User.joins('RIGHT JOIN properties ON users.id = properties.user_id').where('properties.id' => property_ids).uniq.each do |user|
        user.remind_to_send_counters(Helpers::Month.waiting_month[:month])
      end
      redirect_to request.referer, notice: 'Уведомления отправлены'
    else
      redirect_to request.referer, notice: 'Нет прав'
    end
  end

  private

  def item_params
    params[:user][:role_ids] = params[:user][:role_ids].reject(&:blank?).map(&:to_i) if params[:user][:role_ids]
    params[:user].permit(:title, :village_code, :email, :group_ids => [], :role_ids => [])
  end

  def set_item
    @item = User.find(params[:id])
  end

  def set_redirect_path
    if params[:village_id]
      @redirect_path = users_village_path(params[:village_id])
      @village_id = params[:village_id]
    end

    if params[:redirect_path]
      @redirect_path = params[:redirect_path]
    end

  end

end
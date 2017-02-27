class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :users, :meterings]
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


  def send_counters
    if params[:counters].size > 0 && params[:month] && params[:year]
      params[:counters].keys.each do |c|
        counter = Counter.find_by(id: c)
        if counter
          tariff_id =  counter.tariff_for_month( params[:month].to_i, params[:year].to_i ).try(:id)
          hash = { tariff_id: tariff_id, user_id: current_user.id, month: params[:month], year: params[:year] }
          metering = Metering.find_by(hash)
          if metering
            metering.update_attribute( 'value', params[:counters][c] )
          else
            Metering.create( hash.merge!({value: params[:counters][c] }) )
          end
        end
      end
    end
    redirect_to root_path
  end


  def meterings
    @counters = @item.village.counters
    @counter =  @counters.first
    @counter =  Counter.find(params[:counter_id]) if params[:counter_id]
    @items = @counter.meterings.where(user_id: @item.id).order('year DESC, month DESC')
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
class InnsController < ApplicationController
  before_action :authenticate_inn_owner!, only: [:new, :create, :my_inn, 
                                                 :inactive, :active]
  before_action :set_inn, only: [:show, :edit, :update, :inactive, :active]
  before_action :check_inn_owner, only: [:edit, :update, :inactive, :active]

  def new
    @inn = Inn.new
    @address = @inn.build_address
    @payment_method = @inn.build_payment_method 
  end

  def create
    @inn = current_inn_owner.build_inn(inn_params)
    @address = @inn.build_address(address_params)
    @payment_method = @inn.build_payment_method(payment_method_params)

    if @inn.save
      redirect_to @inn, notice: 'Sua Pousada foi registrada com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível concluir o registro da sua pousada.'
      render 'new', status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    @address = @inn.address
    @payment_method = @inn.payment_method
  end

  def update
    @address = @inn.address
    @address.update(address_params)

    @payment_method = @inn.payment_method
    @payment_method.update(payment_method_params) unless payment_method_params.nil?

    if @inn.update(inn_params)
      redirect_to @inn, notice: 'Sua pousada foi atualizada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível atualizar sua pousada.'
      render 'edit', status: :unprocessable_entity
    end
  end

  def my_inn
    @inn = current_inn_owner.inn
    render 'show'
  end

  def inactive
    @inn.inactive!
    redirect_to @inn
  end

  def active
    @inn.active!
    redirect_to @inn
  end

  private

  def address_params
    params.require(:address).permit(:street_name, :number, :complement, 
                                    :neighborhood, :city, :state, :zip_code)
  end

  def inn_params
    params.require(:inn).permit(:brand_name, :registration_number, :phone_number,
                                :description, :policy, :pet_friendly, 
                                :checkin_time, :checkout_time)
  end

  def payment_method_params
    unless params[:payment_method].nil?
      params.require(:payment_method).permit(:bank_transfer, :credit_card, 
                                            :debit_card, :cash, :deposit)
    end
  end

  def set_inn
    @inn = Inn.find(params[:id])
  end

  def check_inn_owner
    unless @inn.inn_owner == current_inn_owner
      redirect_to root_path, notice: 'Você não possui autorização para essa ação.'
    end
  end
end
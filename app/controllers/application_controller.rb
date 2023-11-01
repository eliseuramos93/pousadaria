class ApplicationController < ActionController::Base
  private

  def force_inn_creation_for_owners
    if inn_owner_signed_in? && current_inn_owner.inn.nil?
      return redirect_to new_inn_path, alert: 'É necessário cadastrar uma pousada para continuar.'
    end
  end
end

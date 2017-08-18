class ChipsController < ApplicationController
    before_action :authenticate_user!
    def destroy
        chip = Chip.find_by(id: params[:id])
        chip.destroy
        redirect_to root_path
        
    end
end

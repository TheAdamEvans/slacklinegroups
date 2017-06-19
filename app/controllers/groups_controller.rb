require "json"

class GroupsController < ApplicationController
    http_basic_authenticate_with name: ENV['GROUP_USERNAME'], password: ENV['GROUP_PASSWORD']

    def new
        @group = Group.new
    end

    def edit
        @group = Group.find(params[:id])
        p @group.cords
    end

    def create
        @group = Group.new(group_params)

        if @group.save
            redirect_to @group
        else
            render 'new'
        end
    end

    def update
        @group = Group.find(params[:id])

        if @group.update(group_params)
            redirect_to @group
        else
            render 'edit'
        end
    end

    def show
        @group = Group.find(params[:id])
    end

    def index
        @groups = Group.all
    end

    def destroy
        @group = Group.find(params[:id])
        @group.destroy

        redirect_to groups_path
    end

    private
        def cords_to_a
            # get the params[:group][:cords], if empty use '[]'
            cords = params.dig(:group, :cords).presence || "[]"
            JSON.parse cords
        end

        def group_params
            params.require(:group).permit(:name, :members, :link).merge({cords: cords_to_a})
        end
end

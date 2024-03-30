class GroupsController < ApplicationController
  def index
    @group = Group.new
    @groups = Group.all
  end

  def create
    Group.create!(title: params[:group][:title])
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
    @staff = @group.staffs.all
    @new_group_staff = @group.staffs.build
  end

  def delete; end

  def staff
    @group = Group.find(params[:group_id])
    new_staff =  @group.staffs.create!(email: params[:staff][:email])


    @group.articles.each do |article|
      AddEmailsToArticle.new(emails: [new_staff.email], article:).call
    end

    redirect_to group_path(@group)
  end

end

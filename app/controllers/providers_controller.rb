# Sequreisp - Copyright 2010, 2011 Luciano Ruete
#
# This file is part of Sequreisp.
#
# Sequreisp is free software: you can redistribute it and/or modify
# it under the terms of the GNU Afero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Sequreisp is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Afero General Public License for more details.
#
# You should have received a copy of the GNU Afero General Public License
# along with Sequreisp.  If not, see <http://www.gnu.org/licenses/>.

class ProvidersController < ApplicationController
  before_filter :require_user
  permissions :providers
  # GET /providers
  # GET /providers.xml
  def index
    params[:search] ||= {}
    params[:search][:order] ||= 'ascend_by_name'
    @search = Provider.search(params[:search])
    @providers = @search.paginate(:page => params[:page],:per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.xml
  def show
    @provider = object
    render :action => "edit"
  end

  # GET /providers/new
  # GET /providers/new.xml
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = object
  end

  # POST /providers
  # POST /providers.xml
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if @provider.save
        flash[:notice] = t 'controllers.successfully_created'
        format.html { redirect_back_from_edit_or_to(providers_path) }
        format.xml  { render :xml => @provider, :status => :created, :location => @provider }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.xml
  def update
    @provider = object

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        flash[:notice] = t 'controllers.successfully_updated'
        format.html { redirect_back_from_edit_or_to(providers_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.xml
  def destroy
    @provider = object
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to(providers_url) }
      format.xml  { head :ok }
    end
  end
  private
  def object
    @object ||= Provider.find(params[:id])
  end
end

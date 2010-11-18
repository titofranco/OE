class PagesController < ApplicationController

  layout "magazines"
  
  # GET /pages/1/edit
  def edit
    find_magazine
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
     @page = Page.new(params[:page])
     respond_to do |format|
       if @page.save!
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to magazine_url (@magazine) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
        format.js do 
          responds_to_parent do
            render :update do |page|
              page.insert_html :bottom, "ListOfPages", :partial => "page", :object => @page
              page <<" $('#new_page')[0].reset()"
            end  
          end
        end           
       else
        format.html{ render :action => "add_pages" }
        format.xml{ render :xml => @page.errors, :status => :unprocessable_entity }
       end
     end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html{ redirect_to magazine_url(@page.magazine.id) }
        format.xml{ head :ok }
      else
        format.html{ render :action => "edit" }
        format.xml{ render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html{ redirect_to magazine_url(@page.magazine_id)}
      format.xml{ head :ok }
    end
  end
  

  private 
  def find_magazine
    @magazine_id = params[:magazine_id]
    return (redirect_to(magazines_url)) unless @magazine_id
    @magazine = Magazine.find(@magazine_id)
  end
  

end

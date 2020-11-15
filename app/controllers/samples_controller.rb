class SamplesController < ApplicationController
  before_action :set_sample, only: [:show, :update, :destroy]

  # GET /samples
  def index
    @samples = Sample.all
    render json: @samples
  end

  # GET /samples/1
  def show
    render json: @sample
  end

  # POST /samples
  def create
    sample = Sample.create(name: params[:name])  # Use the name from params to assign the sample's name upon initialization

    if(params[:file])  
			sample.avatar.attach(params[:file])     # If not, #attach to the avatar the file object that is in params[:file]
      sample.url = url_for(sample.avatar)     # Save as the object url the url to the object's avatar using #url_for
    end 

    if sample.save    # If the object can be saved
      render json: sample, status: :created, location: sample 
    else
      render json: sample.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /samples/1
  def update
    if @sample.update(sample_params)
      render json: @sample
    else
      render json: @sample.errors, status: :unprocessable_entity
    end
  end

  # DELETE /samples/1
  def destroy
    @sample.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sample
      @sample = Sample.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sample_params
      params.require(:sample).permit(:name, :file) # Permit the file to be passed into sample_params
    end
end

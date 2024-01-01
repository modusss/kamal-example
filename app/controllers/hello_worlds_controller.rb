class HelloWorldsController < ApplicationController
  before_action :set_hello_world, only: [:show, :edit, :update, :destroy]

  # GET /hello_worlds
  def index
    @hello_worlds = HelloWorld.all
  end

  # GET /hello_worlds/1
  def show
  end

  # GET /hello_worlds/new
  def new
    @hello_world = HelloWorld.new
  end

  # GET /hello_worlds/1/edit
  def edit
  end

  # POST /hello_worlds
  def create
    @hello_world = HelloWorld.new(hello_world_params)
    if @hello_world.save
      redirect_to hello_worlds_path, notice: 'Hello world was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /hello_worlds/1
  def update
    if @hello_world.update(hello_world_params)
      redirect_to hello_worlds_path, notice: 'Hello world was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /hello_worlds/1
  def destroy
    @hello_world.destroy
    redirect_to hello_worlds_url, notice: 'Hello world was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hello_world
      @hello_world = HelloWorld.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hello_world_params
      params.require(:hello_world).permit(:message)
    end
end

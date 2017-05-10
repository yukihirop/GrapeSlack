class SlacksController < ApplicationController
  before_action :set_slack, only: [:show, :edit, :update, :destroy]

  # GET /slacks
  # GET /slacks.json
  def index
    @slacks = Slack.all
  end

  # GET /slacks/1
  # GET /slacks/1.json
  def show
  end

  # GET /slacks/new
  def new
    @slack = Slack.new
  end

  # GET /slacks/1/edit
  def edit
  end

  # POST /slacks
  # POST /slacks.json
  def create
    @slack = Slack.new(slack_params)

    respond_to do |format|
      if @slack.save
        format.html { redirect_to @slack, notice: 'Slack was successfully created.' }
        format.json { render :show, status: :created, location: @slack }
      else
        format.html { render :new }
        format.json { render json: @slack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slacks/1
  # PATCH/PUT /slacks/1.json
  def update
    respond_to do |format|
      if @slack.update(slack_params)
        format.html { redirect_to @slack, notice: 'Slack was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack }
      else
        format.html { render :edit }
        format.json { render json: @slack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slacks/1
  # DELETE /slacks/1.json
  def destroy
    @slack.destroy
    respond_to do |format|
      format.html { redirect_to slacks_url, notice: 'Slack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack
      @slack = Slack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_params
      params.require(:slack).permit(:first_name, :last_name, :email, :password_digest, :profile_img_url)
    end
end

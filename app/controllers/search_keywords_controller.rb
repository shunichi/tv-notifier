class SearchKeywordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search_keyword, only: [:show, :edit, :update, :destroy]

  # GET /search_keywords
  # GET /search_keywords.json
  def index
    @search_keywords = current_user.search_keywords.all
  end

  # GET /search_keywords/1
  # GET /search_keywords/1.json
  def show
  end

  # GET /search_keywords/new
  def new
    @search_keyword = current_user.search_keywords.build
  end

  # GET /search_keywords/1/edit
  def edit
  end

  # POST /search_keywords
  # POST /search_keywords.json
  def create
    @search_keyword = current_user.search_keywords.build(search_keyword_params)

    respond_to do |format|
      if @search_keyword.save
        format.html { redirect_to search_keywords_url, notice: '検索キーワードを登録しました' }
        format.json { render :show, status: :created, location: @search_keyword }
      else
        format.html { render :new }
        format.json { render json: @search_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_keywords/1
  # PATCH/PUT /search_keywords/1.json
  def update
    respond_to do |format|
      if @search_keyword.update(search_keyword_params)
        format.html { redirect_to search_keywords_url, notice: '検索キーワードを更新しました' }
        format.json { render :show, status: :ok, location: @search_keyword }
      else
        format.html { render :edit }
        format.json { render json: @search_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_keywords/1
  # DELETE /search_keywords/1.json
  def destroy
    @search_keyword.destroy
    respond_to do |format|
      format.html { redirect_to search_keywords_url, notice: '検索キーワードを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_keyword
      @search_keyword = current_user.search_keywords.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_keyword_params
      params.require(:search_keyword).permit(:keyword)
    end
end

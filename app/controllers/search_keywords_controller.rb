class SearchKeywordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search_keyword, only: [:destroy]

  def index
    @search_keywords = current_user.search_keywords.default_order
  end

  def create
    @search_keyword = current_user.search_keywords.build(search_keyword_params)

    respond_to do |format|
      if @search_keyword.save
        format.html { redirect_to search_keywords_url, notice: '検索キーワードを登録しました' }
      else
        format.html { redirect_to search_keywords_url }
      end
    end
  end

  def destroy
    @search_keyword.destroy
    respond_to do |format|
      format.html { redirect_to search_keywords_url, notice: '検索キーワードを削除しました' }
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

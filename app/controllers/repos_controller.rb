class ReposController < ApplicationController
  def index
    @search_query = params[:q]
    @repo_response = Repo.search(params[:q])
    render :index
    # uncomment to render just json
    #
    # render json: JSON.pretty_generate(Repo.search(params[:q]).as_json)
  end
end

module Admin
  class TestsController < BaseController
    def index
      @tests = Test.all
    end

    def show
      @test = Test.find(params[:id])
    end
  end
end

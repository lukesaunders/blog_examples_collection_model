require 'spec_helper'

describe JobsController do
  describe "#index" do
    before { get :index }

    it { should respond_with(:success) }
    it { should assign_to :jobs }
    it { should render_template :index }
  end

  describe "#new" do
    before { get :new }

    it { should respond_with(:success) }
    it { should assign_to :job }
    it { should render_template :new }
  end

  describe "#create" do
    before(:each) do
      params = FactoryGirl.attributes_for(:job)
      post :create, :job => params
      @new_job = Job.first
    end

    it { should set_the_flash.to(/created/i) }
    it { should redirect_to job_path(@new_job) }
  end

  describe "#update" do
    before(:each) do
      @job = Factory(:job)
      put :update, :id => @job.id, :name => "New name"
    end

    it { should set_the_flash.to(/updated/i) }
    it { should redirect_to job_path(@new_job) }
  end

  describe "#show" do
    before do
      @job = Factory(:job)
      get :show, :id => @job
    end

    it { should respond_with(:success) }
    it { should assign_to :job }
    it { should render_template :show }
  end

  describe "#edit" do
    before do
      @job = Factory(:job)
      get :edit, :id => @job
    end

    it { should respond_with(:success) }
    it { should assign_to :job }
    it { should render_template :edit }
  end
end

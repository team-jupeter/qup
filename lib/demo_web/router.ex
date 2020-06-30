defmodule DemoWeb.Router do
  use DemoWeb, :router

  import Phoenix.LiveView.Router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {DemoWeb.LayoutView, :root}
    plug DemoWeb.Auth
  end

  # pipeline :entity do
  #   plug DemoWeb.EntityAuth
  # end

  pipeline :bare do
    plug :put_root_layout, {DemoWeb.LayoutView, :bare}
  end

  scope "/", DemoWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/watch/:id", WatchController, :show
    get "/product_watch/:id", ProductWatchController, :show



    live "/presence_users/:name", UserLive.PresenceIndex

    live "/users-live/page/:page", UserLive.Index
    live "/users-live", UserLive.Index
    live "/users-live-scroll", UserLive.IndexManualScroll
    live "/users-live-auto-scroll", UserLive.IndexAutoScroll
    live "/users-live/new", UserLive.New
    live "/users-live/:id", UserLive.Show
    live "/users-live/:id/edit", UserLive.Edit
 
    live "/invoices-live/page/:page", InvoiceLive.Index
    live "/invoices-live", InvoiceLive.Index
    live "/invoices-live-scroll", InvoiceLive.IndexManualScroll
    live "/invoices-live-auto-scroll", InvoiceLive.IndexAutoScroll
    live "/invoices-live/new", InvoiceLive.New
    live "/invoices-live/:id", InvoiceLive.Show
    live "/invoices-live/:id/edit", InvoiceLive.Edit



    live "/aviation/page/:page", Aviation.Index
    live "/aviation", Aviation.Index
    live "/aviation-auto-scroll", Aviation.IndexAutoScroll
    live "/aviation/new", Aviation.New
    live "/aviation/:id", Aviation.Show
    live "/aviation/:id/edit", Aviation.Edit

    # If enabling the LiveDashboard in prod,
    # put it behind proper authentication.
    live_dashboard "/dashboard", metrics: DemoWeb.Telemetry
  end

  scope "/manage", DemoWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/videos", VideoController
    resources "/product_videos", ProductVideoController
  end

  scope "/business", DemoWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/entities", EntityController
    resources "/products", ProductController
    resources "/items", ItemController
    resources "/invoice_items", InvoiceItemController
    resources "/invoices", InvoiceController
    resources "/transactions", TransactionController

  end


  scope "/reports", DemoWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/financial_report", FinancialReportController
    resources "/balance_sheet", BalanceSheetController
    resources "/income_statement", IncomeStatementController
    resources "/cf_statement", CFStatementController
    resources "/equity_statement", EquityStatementController
  end


  scope "/campus", DemoWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/schools", SchoolController
  end

  scope "/nation", DemoWeb do
    pipe_through [:browser]

    resources "/constitutions", ConstitutionController
    resources "/", NationController
  end 

  scope "/supul", DemoWeb do
    pipe_through [:browser]

    resources "/global_supuls", GlobalSupulController
    resources "/nation_supuls", NationSupulController
    resources "/state_supuls", StateSupulController
    resources "/supuls", SupulController
    get "/", GlobalSupulController, :index
  end

  scope "/asset", DemoWeb do
    pipe_through [:browser]

    resources "/real_estates", AssetController
  end

  scope "/gopang", DemoWeb do
    pipe_through [:browser]

    resources "/tickets", TicketController
  end

  # scope "/transaction", DemoWeb do
  #   pipe_through [:browser]

  #   resources "/", TransactionController

  # end




  # scope "/", DemoWeb do
  #   pipe_through [:browser, :bare]

  #   live "/users-live-layout", UserLive.IndexNav
  #   live "/users-live-layout/page/:page", UserLive.IndexNav
  # end
end

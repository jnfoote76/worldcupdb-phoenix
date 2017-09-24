defmodule WorldCupDb.Web.Router do
  use WorldCupDb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WorldCupDb.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", WorldCupDb.Web do
    pipe_through :api

    get "/query/specific_cup", QueryController, :specific_cup
    get "/query/specific_player", QueryController, :specific_player
    get "/query/superstars", QueryController, :superstars
    get "/query/team_historical", QueryController, :team_historical
    get "/query/countrys_players", QueryController, :countrys_players
    get "/query/crest_image", QueryController, :crest_image
    get "/query/goals_at_stadium", QueryController, :goals_at_stadium
    get "/query/most_wins", QueryController, :most_wins
    get "/query/country_rivalry", QueryController, :country_rivalry

    resources "/countries", CountryController, except: [:new, :edit]
    resources "/country_participations", CountryParticipationController, except: [:new, :edit]
    resources "/cups", CupController, except: [:new, :edit]
    resources "/games", GameController, except: [:new, :edit]
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/roster_spots", RosterSpotController, except: [:new, :edit]
    resources "/stadiums", StadiumController, except: [:new, :edit]
  end
end

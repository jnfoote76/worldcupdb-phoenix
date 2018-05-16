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

    get "/query/player_participation", QueryController, :player_participation
    get "/query/player_career", QueryController, :player_career
    get "/query/country_participation", QueryController, :country_participation
    get "/query/country_historical", QueryController, :country_historical
    get "/query/match", QueryController, :match

    resources "/countries", CountryController, except: [:new, :edit]
    resources "/country_participations", CountryParticipationController, except: [:new, :edit]
    resources "/cups", CupController, except: [:new, :edit]
    resources "/games", GameController, except: [:new, :edit]
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/roster_spots", RosterSpotController, except: [:new, :edit]
    resources "/stadiums", StadiumController, except: [:new, :edit]
  end
end

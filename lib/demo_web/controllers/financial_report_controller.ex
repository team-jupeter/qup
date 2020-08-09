# ---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
# ---
defmodule DemoWeb.FinancialReportController do
  use DemoWeb, :controller
  # import Plug.Conn 

  alias Demo.FinancialReports
  alias Demo.Reports.FinancialReport
  alias Demo.Repo
  alias Demo.Supuls
  alias Demo.StateSupuls
  alias Demo.NationSupuls
  alias Demo.Families
  # def action(conn, _) do
  #   args = [conn, conn.params, conn.assigns.current_entity]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  def show(conn, %{"id" => id}) do
    [financial_report] = FinancialReports.get_entity_financial_report!(id)

    case financial_report do
      nil ->
        new(conn, "dummy")

      financial_report ->
        render(conn, "show.html", fr: financial_report)
    end
  end

  # def edit(conn, %{"id" => id}) do
  #   financial_report = FinancialReport |> Demo.Repo.get!(id) 
  #   changeset = FinancialReports.change_financial_report(financial_report)
  #   render(conn, "edit.html", fr: financial_report, changeset: changeset)
  # end

  def edit(conn, %{"id" => id}) do
    financial_report =
      cond do
        Families.get_family(id) != nil ->
          family = Families.get_family(id)
          Repo.preload(family, :financial_report).financial_report

        Supuls.get_supul(id) != nil ->
          supul = Supuls.get_supul(id)
          Repo.preload(supul, :financial_report).financial_report

        StateSupuls.get_state_supul(id) != nil ->
          state_supul = StateSupuls.get_state_supul(id)
          Repo.preload(state_supul, :financial_report).financial_report

        NationSupuls.get_nation_supul(id) != nil ->
          nation_supul = NationSupuls.get_nation_supul(id)
          Repo.preload(nation_supul, :financial_report).financial_report

        true ->
          "error"
      end

    render(conn, "show.html", fr: financial_report)
  end

  def update(conn, %{"id" => id, "financial_report" => financial_report_params}) do
    financial_report = FinancialReport |> Demo.Repo.get!(id)

    case FinancialReports.update_financial_report(financial_report, financial_report_params) do
      {:ok, financial_report} ->
        conn
        |> put_flash(:info, "FinancialReport updated successfully.")

        # |> redirect(to: Routes.financial_report_path(conn, :show, financial_report))
        render(conn, "show.html", fr: financial_report)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", financial_report: financial_report, changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = FinancialReports.change_financial_report(%FinancialReport{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"financial_report" => financial_report_params}, current_entity) do
    case FinancialReports.create_financial_report(current_entity, financial_report_params) do
      {:ok, financial_report} ->
        conn
        |> put_flash(:info, "FinancialReport created successfully.")
        |> redirect(to: Routes.financial_report_path(conn, :show, financial_report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  '''
    No one can delete any records in supul.
    
    def delete(conn, %{"id" => id}) do
      financial_report = FinancialReports.get_entity_financial_report!(id) 
      {:ok, _financial_report} = FinancialReports.delete_financial_report(financial_report)

      conn
      |> put_flash(:info, "FinancialReport deleted successfully.")
      |> redirect(to: Routes.financial_report_path(conn, :index))
    end
  '''
end

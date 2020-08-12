defmodule Demo.Repo.Migrations.CreateT1Pools do
  use Ecto.Migration

  def change do
    create table(:t1_pools, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      
      add(:aed, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:afn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:all, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:amd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:aoa, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ars, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:aud, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:azn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bam, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bbd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bdt, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bgn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bhd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bif, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bnd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bob, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:brl, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bsd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:btn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bwp, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:byn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:bzd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:cad, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:cdf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:chf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:clp, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:cny, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:cop, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:crc, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:cup, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:cve, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:czk, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:djf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:dkk, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:dop, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:dzd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:egp, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ern, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:etb, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:eur, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:fjd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:gbp, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:gel, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ghs, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:gmd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:gnf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:gtq, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:gyd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:hnl, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:hrk, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:htg, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:huf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:idr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ils, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:inr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:iqd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:irr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:isk, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:jmd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:jod, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:jpy, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:kes, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:kgs, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:khr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:kmf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:kpw, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:krw, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:kwd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:kzt, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:lak, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:lbp, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:lkr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:lrd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:lsl, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:lyd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mad, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mdl, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mga, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mkd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mmk, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mnt, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mro, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mur, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mvr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mwk, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mxn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:myr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:mzn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:nad, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ngn, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:nio, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:nok, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:npr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:nzd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:omr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:pab, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:pen, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:pgk, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:php, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:pkr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:pln, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:pyg, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:qar, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ron, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:rsd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:rub, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:rwf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:sar, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:sbd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:scr, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:sdg, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:sek, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:sgd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:sll, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:sos, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:srd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ssp, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:std, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:syp, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:szl, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:thb, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:tjs, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:tmt, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:tnd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:top, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:try, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ttd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:twd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:tzs, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:uah, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:ugx, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:usd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:uyu, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:uzs, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:vef, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:vnd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:vuv, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:wst, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:xaf, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:xcd, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:xof, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:yer, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:zar, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:zmw, :decimal, precision: 12, scale: 4, default: 0.0)

      add :gab_id, references(:gabs, type: :uuid)
 
      timestamps()
    end
  end
end

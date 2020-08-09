defmodule Demo.FiatPools.FiatPool do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "fiat_pools" do
    #?List of countries by currency
    field :aed, :decimal, precision: 12, scale: 4, default: 0.0 
    field :afn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :all, :decimal, precision: 12, scale: 4, default: 0.0 
    field :amd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :aoa, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ars, :decimal, precision: 12, scale: 4, default: 0.0 
    field :aud, :decimal, precision: 12, scale: 4, default: 0.0 
    field :azn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bam, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bbd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bdt, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bgn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bhd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bif, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bnd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bob, :decimal, precision: 12, scale: 4, default: 0.0 
    field :brl, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bsd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :btn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bwp, :decimal, precision: 12, scale: 4, default: 0.0 
    field :byn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :bzd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :cad, :decimal, precision: 12, scale: 4, default: 0.0 
    field :cdf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :chf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :clp, :decimal, precision: 12, scale: 4, default: 0.0 
    field :cny, :decimal, precision: 12, scale: 4, default: 0.0 
    field :cop, :decimal, precision: 12, scale: 4, default: 0.0 
    field :crc, :decimal, precision: 12, scale: 4, default: 0.0 
    field :cup, :decimal, precision: 12, scale: 4, default: 0.0 
    field :cve, :decimal, precision: 12, scale: 4, default: 0.0 
    field :czk, :decimal, precision: 12, scale: 4, default: 0.0 
    field :djf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :dkk, :decimal, precision: 12, scale: 4, default: 0.0 
    field :dop, :decimal, precision: 12, scale: 4, default: 0.0 
    field :dzd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :egp, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ern, :decimal, precision: 12, scale: 4, default: 0.0 
    field :etb, :decimal, precision: 12, scale: 4, default: 0.0 
    field :eur, :decimal, precision: 12, scale: 4, default: 0.0 
    field :fjd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :gbp, :decimal, precision: 12, scale: 4, default: 0.0 
    field :gel, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ghs, :decimal, precision: 12, scale: 4, default: 0.0 
    field :gmd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :gnf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :gtq, :decimal, precision: 12, scale: 4, default: 0.0 
    field :gyd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :hnl, :decimal, precision: 12, scale: 4, default: 0.0 
    field :hrk, :decimal, precision: 12, scale: 4, default: 0.0 
    field :htg, :decimal, precision: 12, scale: 4, default: 0.0 
    field :huf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :idr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ils, :decimal, precision: 12, scale: 4, default: 0.0 
    field :inr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :iqd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :irr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :isk, :decimal, precision: 12, scale: 4, default: 0.0 
    field :jmd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :jod, :decimal, precision: 12, scale: 4, default: 0.0 
    field :jpy, :decimal, precision: 12, scale: 4, default: 0.0 
    field :kes, :decimal, precision: 12, scale: 4, default: 0.0 
    field :kgs, :decimal, precision: 12, scale: 4, default: 0.0 
    field :khr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :kmf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :kpw, :decimal, precision: 12, scale: 4, default: 0.0 
    field :krw, :decimal, precision: 12, scale: 4, default: 0.0 
    field :kwd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :kzt, :decimal, precision: 12, scale: 4, default: 0.0 
    field :lak, :decimal, precision: 12, scale: 4, default: 0.0 
    field :lbp, :decimal, precision: 12, scale: 4, default: 0.0 
    field :lkr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :lrd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :lsl, :decimal, precision: 12, scale: 4, default: 0.0 
    field :lyd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mad, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mdl, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mga, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mkd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mmk, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mnt, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mro, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mur, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mvr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mwk, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mxn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :myr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :mzn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :nad, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ngn, :decimal, precision: 12, scale: 4, default: 0.0 
    field :nio, :decimal, precision: 12, scale: 4, default: 0.0 
    field :nok, :decimal, precision: 12, scale: 4, default: 0.0 
    field :npr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :nzd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :omr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :pab, :decimal, precision: 12, scale: 4, default: 0.0 
    field :pen, :decimal, precision: 12, scale: 4, default: 0.0 
    field :pgk, :decimal, precision: 12, scale: 4, default: 0.0 
    field :php, :decimal, precision: 12, scale: 4, default: 0.0 
    field :pkr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :pln, :decimal, precision: 12, scale: 4, default: 0.0 
    field :pyg, :decimal, precision: 12, scale: 4, default: 0.0 
    field :qar, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ron, :decimal, precision: 12, scale: 4, default: 0.0 
    field :rsd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :rub, :decimal, precision: 12, scale: 4, default: 0.0 
    field :rwf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :sar, :decimal, precision: 12, scale: 4, default: 0.0 
    field :sbd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :scr, :decimal, precision: 12, scale: 4, default: 0.0 
    field :sdg, :decimal, precision: 12, scale: 4, default: 0.0 
    field :sek, :decimal, precision: 12, scale: 4, default: 0.0 
    field :sgd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :sll, :decimal, precision: 12, scale: 4, default: 0.0 
    field :sos, :decimal, precision: 12, scale: 4, default: 0.0 
    field :srd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ssp, :decimal, precision: 12, scale: 4, default: 0.0 
    field :std, :decimal, precision: 12, scale: 4, default: 0.0 
    field :syp, :decimal, precision: 12, scale: 4, default: 0.0 
    field :szl, :decimal, precision: 12, scale: 4, default: 0.0 
    field :thb, :decimal, precision: 12, scale: 4, default: 0.0 
    field :tjs, :decimal, precision: 12, scale: 4, default: 0.0 
    field :tmt, :decimal, precision: 12, scale: 4, default: 0.0 
    field :tnd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :top, :decimal, precision: 12, scale: 4, default: 0.0 
    field :try, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ttd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :twd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :tzs, :decimal, precision: 12, scale: 4, default: 0.0 
    field :uah, :decimal, precision: 12, scale: 4, default: 0.0 
    field :ugx, :decimal, precision: 12, scale: 4, default: 0.0 
    field :usd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :uyu, :decimal, precision: 12, scale: 4, default: 0.0 
    field :uzs, :decimal, precision: 12, scale: 4, default: 0.0 
    field :vef, :decimal, precision: 12, scale: 4, default: 0.0 
    field :vnd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :vuv, :decimal, precision: 12, scale: 4, default: 0.0 
    field :wst, :decimal, precision: 12, scale: 4, default: 0.0 
    field :xaf, :decimal, precision: 12, scale: 4, default: 0.0 
    field :xcd, :decimal, precision: 12, scale: 4, default: 0.0 
    field :xof, :decimal, precision: 12, scale: 4, default: 0.0 
    field :yer, :decimal, precision: 12, scale: 4, default: 0.0 
    field :zar, :decimal, precision: 12, scale: 4, default: 0.0 
    field :zmw, :decimal, precision: 12, scale: 4, default: 0.0

    timestamps()

end

@fields [
  :aed, :afn, :all, :amd, :aoa, :ars, :aud, :azn, :bam, :bbd, :bdt, :bgn, :bhd, 
  :bif, :bnd, :bob, :brl, :bsd, :btn, :bwp, :byn, :bzd, :cad, :cdf, :chf, :chf, 
  :clp, :cny, :cop, :crc, :cup, :cve, :czk, :djf, :dkk, :dop, :dzd, :egp, :ern, 
  :etb, :eur, :fjd, :gbp, :gel, :ghs, :gmd, :gnf, :gtq, :gyd, :hnl, :hrk, :htg, 
  :huf, :idr, :ils, :inr, :iqd, :irr, :isk, :jmd, :jod, :jpy, :kes, :kgs, :khr, 
  :kmf, :kpw, :krw, :kwd, :kzt, :lak, :lbp, :lkr, :lrd, :lsl, :lyd, :mad, :mdl, 
  :mga, :mkd, :mmk, :mnt, :mro, :mur, :mvr, :mwk, :mxn, :myr, :mzn, :nad, :ngn, 
  :nio, :nok, :npr, :nzd, :omr, :pab, :pen, :pgk, :php, :pkr, :pln, :pyg, :qar, 
  :ron, :rsd, :rub, :rwf, :sar, :sbd, :scr, :sdg, :sek, :sgd, :sll, :sos, :srd, 
  :ssp, :std, :syp, :szl, :thb, :tjs, :tmt, :tnd, :top, :try, :ttd, :twd, :tzs, 
  :uah, :ugx, :usd, :uyu, :uzs, :vef, :vnd, :vuv, :wst, :xaf, :xcd, :xof, :yer, 
  :zar, :zmw,
]
  def changeset(fiat_pool, attrs) do
    fiat_pool
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end

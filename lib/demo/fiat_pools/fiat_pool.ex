defmodule Demo.FiatPools.FiatPool do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "fiat_pools" do
    #?List of countries by currency
    field :aed, :decimal, default: 0.0 
    field :afn, :decimal, default: 0.0 
    field :all, :decimal, default: 0.0 
    field :amd, :decimal, default: 0.0 
    field :aoa, :decimal, default: 0.0 
    field :ars, :decimal, default: 0.0 
    field :aud, :decimal, default: 0.0 
    field :azn, :decimal, default: 0.0 
    field :bam, :decimal, default: 0.0 
    field :bbd, :decimal, default: 0.0 
    field :bdt, :decimal, default: 0.0 
    field :bgn, :decimal, default: 0.0 
    field :bhd, :decimal, default: 0.0 
    field :bif, :decimal, default: 0.0 
    field :bnd, :decimal, default: 0.0 
    field :bob, :decimal, default: 0.0 
    field :brl, :decimal, default: 0.0 
    field :bsd, :decimal, default: 0.0 
    field :btn, :decimal, default: 0.0 
    field :bwp, :decimal, default: 0.0 
    field :byn, :decimal, default: 0.0 
    field :bzd, :decimal, default: 0.0 
    field :cad, :decimal, default: 0.0 
    field :cdf, :decimal, default: 0.0 
    field :chf, :decimal, default: 0.0 
    field :clp, :decimal, default: 0.0 
    field :cny, :decimal, default: 0.0 
    field :cop, :decimal, default: 0.0 
    field :crc, :decimal, default: 0.0 
    field :cup, :decimal, default: 0.0 
    field :cve, :decimal, default: 0.0 
    field :czk, :decimal, default: 0.0 
    field :djf, :decimal, default: 0.0 
    field :dkk, :decimal, default: 0.0 
    field :dop, :decimal, default: 0.0 
    field :dzd, :decimal, default: 0.0 
    field :egp, :decimal, default: 0.0 
    field :ern, :decimal, default: 0.0 
    field :etb, :decimal, default: 0.0 
    field :eur, :decimal, default: 0.0 
    field :fjd, :decimal, default: 0.0 
    field :gbp, :decimal, default: 0.0 
    field :gel, :decimal, default: 0.0 
    field :ghs, :decimal, default: 0.0 
    field :gmd, :decimal, default: 0.0 
    field :gnf, :decimal, default: 0.0 
    field :gtq, :decimal, default: 0.0 
    field :gyd, :decimal, default: 0.0 
    field :hnl, :decimal, default: 0.0 
    field :hrk, :decimal, default: 0.0 
    field :htg, :decimal, default: 0.0 
    field :huf, :decimal, default: 0.0 
    field :idr, :decimal, default: 0.0 
    field :ils, :decimal, default: 0.0 
    field :inr, :decimal, default: 0.0 
    field :iqd, :decimal, default: 0.0 
    field :irr, :decimal, default: 0.0 
    field :isk, :decimal, default: 0.0 
    field :jmd, :decimal, default: 0.0 
    field :jod, :decimal, default: 0.0 
    field :jpy, :decimal, default: 0.0 
    field :kes, :decimal, default: 0.0 
    field :kgs, :decimal, default: 0.0 
    field :khr, :decimal, default: 0.0 
    field :kmf, :decimal, default: 0.0 
    field :kpw, :decimal, default: 0.0 
    field :krw, :decimal, default: 0.0 
    field :kwd, :decimal, default: 0.0 
    field :kzt, :decimal, default: 0.0 
    field :lak, :decimal, default: 0.0 
    field :lbp, :decimal, default: 0.0 
    field :lkr, :decimal, default: 0.0 
    field :lrd, :decimal, default: 0.0 
    field :lsl, :decimal, default: 0.0 
    field :lyd, :decimal, default: 0.0 
    field :mad, :decimal, default: 0.0 
    field :mdl, :decimal, default: 0.0 
    field :mga, :decimal, default: 0.0 
    field :mkd, :decimal, default: 0.0 
    field :mmk, :decimal, default: 0.0 
    field :mnt, :decimal, default: 0.0 
    field :mro, :decimal, default: 0.0 
    field :mur, :decimal, default: 0.0 
    field :mvr, :decimal, default: 0.0 
    field :mwk, :decimal, default: 0.0 
    field :mxn, :decimal, default: 0.0 
    field :myr, :decimal, default: 0.0 
    field :mzn, :decimal, default: 0.0 
    field :nad, :decimal, default: 0.0 
    field :ngn, :decimal, default: 0.0 
    field :nio, :decimal, default: 0.0 
    field :nok, :decimal, default: 0.0 
    field :npr, :decimal, default: 0.0 
    field :nzd, :decimal, default: 0.0 
    field :omr, :decimal, default: 0.0 
    field :pab, :decimal, default: 0.0 
    field :pen, :decimal, default: 0.0 
    field :pgk, :decimal, default: 0.0 
    field :php, :decimal, default: 0.0 
    field :pkr, :decimal, default: 0.0 
    field :pln, :decimal, default: 0.0 
    field :pyg, :decimal, default: 0.0 
    field :qar, :decimal, default: 0.0 
    field :ron, :decimal, default: 0.0 
    field :rsd, :decimal, default: 0.0 
    field :rub, :decimal, default: 0.0 
    field :rwf, :decimal, default: 0.0 
    field :sar, :decimal, default: 0.0 
    field :sbd, :decimal, default: 0.0 
    field :scr, :decimal, default: 0.0 
    field :sdg, :decimal, default: 0.0 
    field :sek, :decimal, default: 0.0 
    field :sgd, :decimal, default: 0.0 
    field :sll, :decimal, default: 0.0 
    field :sos, :decimal, default: 0.0 
    field :srd, :decimal, default: 0.0 
    field :ssp, :decimal, default: 0.0 
    field :std, :decimal, default: 0.0 
    field :syp, :decimal, default: 0.0 
    field :szl, :decimal, default: 0.0 
    field :thb, :decimal, default: 0.0 
    field :tjs, :decimal, default: 0.0 
    field :tmt, :decimal, default: 0.0 
    field :tnd, :decimal, default: 0.0 
    field :top, :decimal, default: 0.0 
    field :try, :decimal, default: 0.0 
    field :ttd, :decimal, default: 0.0 
    field :twd, :decimal, default: 0.0 
    field :tzs, :decimal, default: 0.0 
    field :uah, :decimal, default: 0.0 
    field :ugx, :decimal, default: 0.0 
    field :usd, :decimal, default: 0.0 
    field :uyu, :decimal, default: 0.0 
    field :uzs, :decimal, default: 0.0 
    field :vef, :decimal, default: 0.0 
    field :vnd, :decimal, default: 0.0 
    field :vuv, :decimal, default: 0.0 
    field :wst, :decimal, default: 0.0 
    field :xaf, :decimal, default: 0.0 
    field :xcd, :decimal, default: 0.0 
    field :xof, :decimal, default: 0.0 
    field :yer, :decimal, default: 0.0 
    field :zar, :decimal, default: 0.0 
    field :zmw, :decimal, default: 0.0

    timestamps()

end

@fields [
  :aed, :afn, :all, :amd, :aoa, :ars, :aud, :azn, :bam, :bbd, :bdt, :bgn, :bhd, :bif, :bnd, :bob, :brl, :bsd, :btn, :bwp, :byn, :bzd, :cad, :cdf, :chf, :chf, :clp, :cny, :cop, :crc, :cup, :cve, :czk, :djf, :dkk, :dop, :dzd, :egp, :ern, :etb, :eur, :fjd, :gbp, :gel, :ghs, :gmd, :gnf, :gtq, :gyd, :hnl, :hrk, :htg, :huf, :idr, :ils, :inr, :iqd, :irr, :isk, :jmd, :jod, :jpy, :kes, :kgs, :khr, :kmf, :kpw, :krw, :kwd, :kzt, :lak, :lbp, :lkr, :lrd, :lsl, :lyd, :mad, :mdl, :mga, :mkd, :mmk, :mnt, :mro, :mur, :mvr, :mwk, :mxn, :myr, :mzn, :nad, :ngn, :nio, :nok, :npr, :nzd, :omr, :pab, :pen, :pgk, :php, :pkr, :pln, :pyg, :qar, :ron, :rsd, :rub, :rwf, :sar, :sbd, :scr, :sdg, :sek, :sgd, :sll, :sos, :srd, :ssp, :std, :syp, :szl, :thb, :tjs, :tmt, :tnd, :top, :try, :ttd, :twd, :tzs, :uah, :ugx, :usd, :uyu, :uzs, :vef, :vnd, :vuv, :wst, :xaf, :xcd, :xof, :yer, :zar, :zmw,
]
  def changeset(fiat_pool, attrs) do
    fiat_pool
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end

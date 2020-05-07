{:ok, a} = GenStage.start_link(A, 0)    # starting from zero
{:ok, b} = GenStage.start_link(B, 2)    # multiply by 2
{:ok, c} = GenStage.start_link(C, 1000) # sleep for a second

GenStage.sync_subscribe(c, to: b)
GenStage.sync_subscribe(b, to: a)

# Sleep so we see events printed.
Process.sleep(:infinity)


?#
{:ok, a} = GenStage.start_link(A, 0)     # starting from zero
{:ok, b} = GenStage.start_link(B, 2)     # multiply by 2

{:ok, c1} = GenStage.start_link(C, 1000) # sleep for a second
{:ok, c2} = GenStage.start_link(C, 1000) # sleep for a second
{:ok, c3} = GenStage.start_link(C, 1000) # sleep for a second
{:ok, c4} = GenStage.start_link(C, 1000) # sleep for a second

GenStage.sync_subscribe(c1, to: b)
GenStage.sync_subscribe(c2, to: b)
GenStage.sync_subscribe(c3, to: b)
GenStage.sync_subscribe(c4, to: b)
GenStage.sync_subscribe(b, to: a)

# Sleep so we see events printed.
Process.sleep(:infinity)

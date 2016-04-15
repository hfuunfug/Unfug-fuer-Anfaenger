\part{Grafische Beispiele}

# Graphic examples

The following chapter contains a list of graphics which are generated using
pandocfilters and are (as source) embedded directly into the source of the
document.

These examples are piped through graphviz to compile the source of them to the
actual images:

```{#img:graphviz1 .graphviz caption="Graphviz simpel"}
digraph G {Hello->World}
```

And a complex one goes here, from the official graphviz homepage:

```{#img:graphviz2 .graphviz caption="More complex graphviz"}
digraph G {

  subgraph cluster_0 {
    style=filled;
    color=lightgrey;
    node [style=filled,color=white];
    a0 -> a1 -> a2 -> a3;
    label = "process #1";
  }

  subgraph cluster_1 {
    node [style=filled];
    b0 -> b1 -> b2 -> b3;
    label = "process #2";
    color=blue
  }
  start -> a0;
  start -> b0;
  a1 -> b3;
  b2 -> a3;
  a3 -> a0;
  a3 -> end;
  b3 -> end;

  start
    [shape=Mdiamond];
  end
    [shape=Msquare];
}
```

Example MSC using boxes:

```{#img:msc .msc caption="msc example"}
msc {

   # The entities
   A, B, C, D;

   # Small gap before the boxes
   |||;

   # Next four on same line due to ','
   A box A [label="box"],
   B rbox B [label="rbox"],
   C abox C [label="abox"],
   D note D [label="note"];

   # Example of the boxes with filled backgrounds
   A abox B [label="abox", textbgcolour="#ff7f7f"];
   B rbox C [label="rbox", textbgcolour="#7fff7f"];
   C note D [label="note", textbgcolour="#7f7fff"];
}
```

```{#img:blockdiag .blockdiag caption="Blockdiag example"}
blockdiag {
A -> B -> C
}
```

```{#img:seqdiag .seqdiag caption="seqdiag example"}
seqdiag {
  browser  -> webserver [label = "GET /index.html"];
  browser <-- webserver;
  browser  -> webserver [label = "POST /blog/comment"];
              webserver  -> database [label = "INSERT comment"];
              webserver <-- database;
  browser <-- webserver;
}
```

```{#img:actdiag .actdiag caption="actdiag example"}
actdiag {
  write -> convert -> image

  lane user {
     label = "User"
     write [label = "Writing reST"];
     image [label = "Get diagram IMAGE"];
  }
  lane actdiag {
     convert [label = "Convert reST to Image"];
  }
}
```

```{#img:nwdiag .nwdiag caption="nwdiag example"}
nwdiag {
  network dmz {
      address = "210.x.x.x/24"

      web01 [address = "210.x.x.1"];
      web02 [address = "210.x.x.2"];
  }
  network internal {
      address = "172.x.x.x/24";

      web01 [address = "172.x.x.1"];
      web02 [address = "172.x.x.2"];
      db01;
      db02;
  }
}
```

```{#img:packetdiag .packetdiag caption="packetdiag example"}
{
  colwidth = 32
  node_height = 72

  0-15: Source Port
  16-31: Destination Port
  32-63: Sequence Number
  64-95: Acknowledgment Number
  96-99: Data Offset
  100-105: Reserved
  106: URG [rotate = 270]
  107: ACK [rotate = 270]
  108: PSH [rotate = 270]
  109: RST [rotate = 270]
  110: SYN [rotate = 270]
  111: FIN [rotate = 270]
  112-127: Window
  128-143: Checksum
  144-159: Urgent Pointer
  160-191: (Options and Padding)
  192-223: data [colheight = 3]
}
```

```{#img:rackdiag .rackdiag caption="rackdiag example"}
rackdiag {
  // define height of rack
  16U;

  // define rack items
  1: UPS [2U];
  3: DB Server
  4: Web Server
  5: Web Server
  6: Web Server
  7: Load Balancer
  8: L3 Switch
}
```

```{#img:r .r caption="r example"}
y <- c(1,4,9,13,10)
x <- c(1,2,3,4, 5 )
xx <- seq(1, 5, length.out=250)

plot(x, y)

fit <- lm(y~x)
label1 <- bquote(italic(R)^2 == .(format(summary(fit)$adj.r.squared, digits=4)))
lines(xx, predict(fit, data.frame(x=xx)))
fnc1 <- bquote(y == .(coef(fit)[[2]]) * x + .(coef(fit)[[1]]))


fit <- lm(y~poly(x,3, raw = TRUE))
label2 <- bquote(italic(R)^2 == .(format(summary(fit)$adj.r.squared, digits=4)))
lines(xx, predict(fit, data.frame(x=xx)))
fnc2 <- bquote(y == .(coef(fit)[[4]]) * x^3 + .(coef(fit)[[3]]) * x^2 + .(coef(fit)[[2]]) * x + .  (coef(fit)[[1]]))

labels <- c(label1, fnc1, label2, fnc2)
legend("topleft", bty="n", legend=as.expression(labels))
```

```{#img:plantuml .plantuml caption="plantuml example"}
@startuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response

Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
@enduml
```

\input{src/tikz_example}


import React from "react";
import Train from "./Train";
import games from "./data/games";
import util from "./util";
import * as R from "ramda";

const Trains = ({ match }) => {
  let game = games[match.params.game];
  let trains = util.fillArray(R.prop("quantity"), game.trains);

  return (
    <div class="cards trains">
      {R.addIndex(R.map)(
        (train, index) => (
          <Train train={train} key={`train-${train.name}-${index}`} />
        ),
        trains
      )}
    </div>
  );
};

export default Trains;

def test_data
  [
    {
      input: "PLACE 0,0,NORTH\r
              MOVE\r
              REPORT",
      output: "0,1,NORTH"
    },

    {
      input: "PLACE 0,0,NORTH\r
              LEFT\r
              REPORT",
      output: "0,0,WEST"
    },

    {
      input: "PLACE 1,2,EAST\r
              MOVE\r
              MOVE\r
              LEFT\r
              MOVE\r
              REPORT",
      output: "3,3,NORTH"
    }
  ]
end
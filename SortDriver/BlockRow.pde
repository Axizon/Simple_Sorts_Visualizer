class BlockRow {
  Block[] row;

  int numBlocks;
  int minBlockSize;
  int maxBlockSize;
  int algorithm;
  boolean sorted;
  int comparisons;
  int swaps;

  //variables for bubble sort keep track of
  //start of the sorted portion
  //two test positions to compare
  int sortedStart;
  int testPos0;
  int testPos1;
  
  //variables for selection sort
  int currentPos;
  int smallestPos;
  int testPos;
  
  //variables for insertion sort
  int sortedEnd;
  int newValue;

  BlockRow(int nb, int algo, boolean ordered) {
    numBlocks = nb;
    minBlockSize = MIN_BLOCK_SIZE;
    algorithm = algo;
    sorted = ordered;

    setSortVars();

    row = new Block[numBlocks];
    setupBlocks(ordered);
  }//setup

  void setSortVars() {
    sortedStart = numBlocks;
    testPos0 = 0;
    testPos1 = 1;
    comparisons = 0;
    swaps = 0;
    currentPos = 0;
    smallestPos = 0;
    testPos = 0;
    newValue = 1;
    sortedEnd = 0;
  }//setSortVars

  void swap(int i0, int i1) {
    int a = row[i0].sideLength;
    int b = row[i1].sideLength;
    row[i0].sideLength = b;
    row[i1].sideLength = a;
  }//swap

  void sort() {
    if (algorithm == BUBBLE) {
      bubbleSortOnce();
    }//bubble sort
    else if (algorithm == SELECTION) {
      selectionSortOnce();
    }//selection sort
    else if (algorithm == INSERTION) {
      insertionSortOnce();
    }//insertion sort
  }//sort

  void bubbleSortOnce() {
    if (sortedStart != 0) {
      if (testPos1 != sortedStart) {
        comparisons++;
        if (row[testPos0].sideLength > row[testPos1].sideLength) {
          swap(testPos0, testPos1);
          swaps++;
          rearrange();
        }
        testPos0++;
        testPos1++;
      }
      if (testPos1 == sortedStart) {
        testPos0 = 0;
        testPos1 = 1;
        sortedStart -= 1;
      }
    }
  }//bubbleSortOnce

  void selectionSortOnce() {
  if (currentPos != numBlocks) {
    if (testPos != numBlocks) {
      if (row[testPos].sideLength < row[smallestPos].sideLength) {
        smallestPos = testPos;
      }
      testPos++;
      comparisons++;
    }
    else {
      if (currentPos != smallestPos) {
        swap(currentPos, smallestPos);
        swaps++;
        rearrange();
      }
      currentPos++;
      testPos = currentPos;
      smallestPos =  currentPos;
    }
  }
}//selectionSortOnce

void insertionSortOnce() {
  if (sortedEnd != numBlocks - 1) {
    Block blockToInsert =  new Block(0, 0, row[newValue].sideLength);
    comparisons++;
    if (currentPos >= 0 && row[currentPos].sideLength > blockToInsert.sideLength) {
      row[currentPos + 1].sideLength = row[currentPos].sideLength;
      row[currentPos].sideLength = blockToInsert.sideLength;
      currentPos -= 1;
      newValue -=1;
      swaps++;
      rearrange();
    }//shift down
    else {
    sortedEnd++;
    currentPos = sortedEnd;
    newValue = sortedEnd + 1;

    }
  }
}//insertionSortOnce

/*==================================
  LEAVE ALL OF THIS CODE ALONE.

  The code below this line is here to help
  run the program, it is all working, and
  does not need to be modified.
  ==================================*/


  void setupBlocks(boolean ordered) {
    maxBlockSize = 0;
    minBlockSize = MIN_BLOCK_SIZE;
    int topSize = 100;
    if (ordered) {
      topSize = 10;
    }
    for (int i=0; i < row.length; i++) {
      int bsize = int(random(minBlockSize, topSize));
      if (maxBlockSize < bsize) {
        maxBlockSize = bsize;
      }//keep maxBlockSize up to date
      row[i] = new Block(0, 0, bsize);
      if (ordered) {
        minBlockSize = bsize;
        topSize = minBlockSize+5;
      }//keep thigns ordered
    }//array loop
    rearrange();
    setSortVars();
  }//setupBlocks

  void rearrange() {
    int x = 5;
    int y = 25;
    int topSize = 0;
    for (int i=0; i < row.length; i++) {
      if (topSize < row[i].sideLength) {
        topSize = row[i].sideLength;
      }//update topSize
      if (x + row[i].sideLength >= width) {
        x = 5;
        y+= topSize + 5;
      }//new row
      row[i].move(x, y);
      x+= row[i].sideLength +2;
    }//array loop
  }//rearrange

  void display() {
    for (int i=0; i < row.length; i++) {
      if (algorithm == BUBBLE) {
        setBubbleColor(i);
      }//bubble sort color
      else if (algorithm == SELECTION) {
        setSelectionColor(i);
      }//selection sort coloring
      else if (algorithm == INSERTION) {
        setInsertionColor(i);
      }//insertion sort coloring
      row[i].display();
    }//array loop
  }//viewBlocks

void setBubbleColor(int i) {
  color c;
  if (i >= sortedStart) {
    c = SORTED;
  }//sorted color
  else if (i == testPos0) {
    c = CURRENT;
  }//test color
  else if (i == testPos1) {
    c = TEST;
  }//test color
  else {
    c = UNSORTED;
  }//unsorted color
  row[i].inside = c;
}//setBubbleColor

void setSelectionColor(int i) {
  color c;
  if (i < currentPos) {
    c = SORTED;
  }//sorted color
  else if (i == currentPos) {
    c = CURRENT;
  }//test color
  else if (i == testPos) {
    c = TEST;
  }//test color
  else if (i == smallestPos) {
    c = SMALLEST;
  }//smallest color
  else {
    c = UNSORTED;
  }//unsorted color
  row[i].inside = c;
}//setBubbleColor

void setInsertionColor(int i) {
  color c;
  if (i == newValue) {
    c = SMALLEST;
  }//test color
  else if (i == currentPos) {
    c = CURRENT;
  }//current color
  else if (i <= sortedEnd) {
    c = SORTED;
  }//sorted color
  else {
    c = UNSORTED;
  }//unsorted color
  row[i].inside = c;
}//setBubbleColor

  void shuffle() {
    for (int i=0; i<row.length; i++) {
      int i0 = int(random(0, row.length));
      int i1 = int(random(0, row.length));
      swap(i0, i1);
    }//array loop
    rearrange();
    setSortVars();
    ordered = false;
  }//shuffle

  int getSize(int i) {
    if (i < row.length && i >= 0) {
      return row[i].sideLength;
    }//valid index
    return -1;
  }//getSize

  void setColor(int i, color c) {
    row[i].inside = c;
  }//setColor
}//BlockRow

// Zero Fill Right Shift
int zfrs(int n, int amount) {
  return (n & 0xffffffff) >> amount;
}
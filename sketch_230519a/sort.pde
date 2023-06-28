import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

void sortPieces(ArrayList<APiece_lumber> pieces) {
  Collections.sort(pieces, new Comparator<APiece_lumber>() {
    public int compare(APiece_lumber piece1, APiece_lumber piece2) {
      float key1 = piece1.startY + piece1.endY_another;
      float key2 = piece2.startY + piece2.endY_another;
      if (key1 == key2) {
        // 第1キーが同じ場合は第2キーで比較
        float subKey1 = piece1.startX + piece1.endX_another;
        float subKey2 = piece2.startX + piece2.endX_another;
        return Float.compare(subKey1, subKey2);
      }
      return Float.compare(key1, key2);
    }
  });
}

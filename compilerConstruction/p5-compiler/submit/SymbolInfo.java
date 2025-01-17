/*
 * Code formatter project
 * CS 4481
 */
package submit;

import submit.ast.VarType;

/**
 *
 * @author edwajohn
 */
public class SymbolInfo {

  private final String id;
  // In the case of a function, type is the return type
  private final VarType type;
  private final boolean function;

  private int offset;

  public SymbolInfo(String id, VarType type, boolean function) {
    this.id = id;
    this.type = type;
    this.function = function;
    this.offset = 0;
  }

  public SymbolInfo(String id, VarType type, boolean function, int offset) {
    this.id = id;
    this.type = type;
    this.function = function;
    this.offset = offset;
  }

  public SymbolInfo copy() {
    return new SymbolInfo(id, type, function, offset);
  }

  @Override
  public String toString() {
    return "<" + id + ", " + type + '>';
  }

  public VarType getType() {
    return type;
  }

  public int getOffset() {
    return offset;
  }

  public void setOffset(int offset) {
    this.offset = offset;
  }

  public boolean isFunction() {
    return function;
  }
}

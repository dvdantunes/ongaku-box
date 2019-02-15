/**
 * Client configuration
 */

export const isEmpty = (object) => {

  for (var key in object) {
    if (object.hasOwnProperty(key)) {
      return false;
    }
  }

  return true;
}

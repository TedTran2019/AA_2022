export const getCSRF = () => {
  return document.querySelector("meta[name='csrf-token']").getAttribute("content");
}

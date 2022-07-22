export const getCSRFToken = () => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]');
  return csrfToken ? csrfToken.getAttribute('content') : null;
}

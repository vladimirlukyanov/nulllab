export const format_date = (date) => {
  const dateOptions: object = {
    year: "numeric",
    month: "long",
    day: "numeric",
  };

  return new Date(date).toLocaleDateString("en-US", dateOptions);
};

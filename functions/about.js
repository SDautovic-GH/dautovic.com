export async function onRequest(context) {
  const url = new URL(context.request.url);
  url.pathname = "/page.html";
  url.searchParams.set("slug", "about");
  return Response.redirect(url.toString(), 301);
}

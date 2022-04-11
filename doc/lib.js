function extract(collection, property) {
  return collection.map(function(item) {
    return item[property];
  });
}

function query(q, onComplete) {
  fetch('https://m290.bbz.cloud/query', {
    method: 'POST', body: JSON.stringify({
      query: q
    })
  }).then(res => res.json()).then(res => {
    onComplete(res);
  });
}

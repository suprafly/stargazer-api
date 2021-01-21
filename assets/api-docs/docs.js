/**
 * @api {post} /api/repos Track new repository
 * @apiName PostRepo
 * @apiGroup Repo
 *
 * @apiParam {String} owner Repository's owner's username
 * @apiParam {String} name Repository's name
 *
 * @apiSuccess {List} new  List of users who have starred in this date range.
 * @apiSuccess {List} former  List of users who have unstarred in this date range.
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *       "owner": "suprafly",
 *       "name": "stargazers"
 *     }
 */

/**
 * @api {post} /api/repos/:owner/:name Get stargazer information
 * @apiName GetRepoStargazers
 * @apiGroup Repo
 *
 * @apiParam {String} from  Beginning of a date range for the query, with the format YYYY-MM-DD.
 * @apiParam {String} to  Beginning of a date range for the query, with the format YYYY-MM-DD.
 *
 * @apiSuccess {List} new  List of users who have starred in this date range.
 * @apiSuccess {List} former  List of users who have unstarred in this date range.
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *       "new": []
 *       "former": []
 *     }
 */

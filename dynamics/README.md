# Running dynamics data

Per-running-activity sample data is stored here as:

`dynamics/<garmin_activity_id>.json`

The activity ID is the `source_activity_id` shown in `overview.json`.

Each file uses a compact columnar structure:

- `activity_id`
- `activity_name`
- `sample_count`
- `fields`: ordered column names
- `samples`: arrays whose values correspond to `fields`
- `metric_indices`: Garmin descriptor positions used for normalization
- `metric_descriptors`: original Garmin descriptor metadata

Normalized fields are included whenever Garmin supplies them:

- `timestamp`
- `distance_m`
- `speed_mps`
- `heart_rate_bpm`
- `cadence_spm`
- `ground_contact_time_ms`
- `ground_contact_balance_pct`
- `vertical_oscillation_cm`
- `vertical_ratio_pct`
- `stride_length_m`
- `power_w`

The normal scheduled Garmin collector publishes these files for running activities. Files are only committed when their content changes, so repeated syncs do not create unnecessary revisions.

Use these files for within-run mechanical drift analysis, e.g. comparing cadence, GCT, vertical ratio and oscillation between early and late kilometres at similar pace/grade.